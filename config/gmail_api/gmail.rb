require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"
require 'nokogiri'
require 'json'

OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Automation Gmail".freeze
CREDENTIALS_PATH = "/gmail_api/credentials.json"
TOTAL_ATTEMPTS = 10.freeze
# The file token.yaml stores the user's access and refresh tokens, and is
# created automatically when the authorization flow completes for the first
# time.
TOKEN_PATH = "config/gmail_api/token.yaml".freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

class Gmail 

  attr_reader :service

  def initialize()
    authorize()
  end
  
  def authorize
    begin
      gmail_tokens = YAML.load_file("/gmail_tokens.yaml")
      client = gmail_tokens['installed']['client_id']
      secret = gmail_tokens['client_secret']['client_id']
      client_id = Google::Auth::ClientId.new(client, secret)
      token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
      authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
      user_id = "default"
      credentials = authorizer.get_credentials user_id
      if credentials.nil?
        url = authorizer.get_authorization_url(base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the resulting code after authorization\n" + url
        puts url.inspect
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id,
                                                                        code: code,
                                                                        base_url: OOB_URI)
      end
      credentials
    
    end
  end

  def search_email(q_search)
    begin
      # Initialize the API
      service = Google::Apis::GmailV1::GmailService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = authorize

      user_id = 'me'

      count_wait=0

      begin
        sleep(10)
        count_wait+=1
      end until !service.list_user_messages(user_id, q: q_search).messages.nil? or count_wait >= TOTAL_ATTEMPTS
      result = service.list_user_messages(user_id, q: q_search)
      #puts "Total message: #{result.messages.nil?}"
      if !result.messages.nil?
        id_msg=result.messages[0].id
        result = service.get_user_message(user_id, id_msg)
        msg_response= result.payload.body.data
        # if trash == true
        #   puts "Sending message email to TRASH".yellow
        #   service.trash_user_message(user_id, id_msg)
        # end
      else
        puts "---------------------------------".red
        puts "ACCESS CODE NOT FOUND".red
        puts "---------------------------------".red
        msg_response = nil
      end
      return msg_response
    rescue Exception => e
      puts e.message.red
      raise e.message
    end

  end 

  def get_access_code_newegg(query) 
    access_code=nil
    begin
      puts "---------------------------------------------"
      puts "STEP: SEACH FOR CODE EMAIL IN GMAIL ACCOUNT".green
      puts "---------------------------------------------"
      message = search_email(query)
      if !message.nil?
        document = Nokogiri::HTML.parse(message)
        
        access_code = document.xpath("//strong").text
      else
        puts "ERROR: Unable to find ACCESS CODE"
        return nil
      end

    rescue Exception => e
      puts e.message.red
      return nil
      # raise e.message
    end
    return access_code
  end # end get_access_code_newegg


end
#for testing porpouses
#test = Gmail.new()
# service = Google::Apis::GmailV1::GmailService.new
# service.client_options.application_name = APPLICATION_NAME
# service.authorization = authorize
  # begin
  #   file = File.open("Raw.html", "w")
  #   file.write(parsed_message) 
  # rescue IOError => e
  #   #some error occur, dir not writable etc.
  # ensure
  #   file.close unless file.nil?
  # end


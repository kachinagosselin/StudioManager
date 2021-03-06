class AppointmentreminderController < ApplicationController
require 'twilio-ruby'

  # your Twilio authentication credentials
  ACCOUNT_SID = 'AC01c958af473d4bf154e554c1aadf681f'
  ACCOUNT_TOKEN = 'ebe0a98d4cd312fd7f138ccf9444618a'

  # base URL of this application
  BASE_URL = "http://0.0.0.0:3000/appointmentreminder"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '6176101988'

  def index
  end

  # Use the Twilio REST API to initiate an outgoing call
  def makecall
    if !params['number']
        redirect_to :back, 'msg' => 'Invalid phone number'
      return
    end
  
    @client = Twilio::REST::Client.new ACCOUNT_SID, ACCOUNT_TOKEN
    @client.account.sms.messages.create(
      from: '+16173408703',
      to: '+1'+ params['number'] +'',
      body: 'Hey there!'
    )

    # parameters sent to Twilio REST API
    #data = {
    #  :from => CALLER_ID,
    #  :to => params['number'],
    #  :url => BASE_URL + '/reminder',
    #}

    #begin
    #  client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    #  client.account.calls.create data
    #rescue StandardError => bang
    #  redirect_to :back, 'msg' => "Error #{bang}"
    #  return
    #end

    redirect_to :back, 'msg' => "Calling #{params['number']}..."
  end
  # @end snippet

  # @start snippet
  # TwiML response that reads the reminder to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def reminder
    @post_to = BASE_URL + '/directions'
    render :action => "reminder.xml.builder", :layout => false 
  end
  # @end snippet

  # @start snippet
  # TwiML response that inspects the caller's menu choice:
  # - says good bye and hangs up if the caller pressed 3
  # - repeats the menu if caller pressed any other digit besides 2 or 3
  # - says the directions if they pressed 2 and redirect back to menu
  def directions
    if params['Digits'] == '3'
      redirect_to :action => 'goodbye'
      return
    end

    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action => 'reminder'
      return
    end

    @redirect_to = BASE_URL + '/reminder'
    render :action => "directions.xml.builder", :layout => false 
  end
  # @end snippet

  # TwiML response saying with the goodbye message. Twilio will detect no
  # further commands after the Say and hangup
  def goodbye
    render :action => "goodbye.xml.builder", :layout => false 
  end

end

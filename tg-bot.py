import telebot
import os
import requests
import json

RESPONSE_200 = {
    "statusCode": 200,
    "headers": { },
    "body": ""
}

def lambda_handler(event,context):
    update = telebot.types.JsonDeserializable.check_json(event["body"])
    BOT_TOKEN = os.environ['BOT_TOKEN']
    ADMINCHAT = os.environ['ADMINCHAT']
    GATEWAY = os.environ['GATEWAY']
    USERNAME = os.environ['USERNAME']
    PASSWORD = os.environ['PASSWORD']

    url = 'http://' + GATEWAY + ':9900/api'
    url2 = 'http://' + GATEWAY + ':9900/answer'


    headers = {'Content-type': 'application/json',  'Accept': 'text/plain','Content-Encoding': 'utf-8'}

    message = update.get('message')
    if not message:
        return RESPONSE_200
    
    chat = message.get('chat')
    user = message.get('from')

    bot = telebot.TeleBot(BOT_TOKEN, threaded=False)


    command = message.get('text', '')

    if chat['id'] == int(ADMINCHAT):

        if command and command == '/thischat':
            bot.send_message(chat['id'], chat['id'], reply_to_message_id=message['message_id'])
            return RESPONSE_200

        elif '/command' in command:
            try:
                data = {"Name" : command.replace('/command ',''), "Email" : "admin"}
                answer = requests.post(url, data=json.dumps(data), headers=headers, auth=(USERNAME, PASSWORD))
                out = requests.get(url2, headers=headers, auth=(USERNAME, PASSWORD))
                bot.send_message(chat['id'], str(out.text))
            except:
                bot.send_message(chat['id'], 'Something went wrong')
    
        else:
            bot.send_message(chat['id'], 'I dont know(')
    else:
        bot.send_message(chat['id'], 'not access')

    return RESPONSE_200
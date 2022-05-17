import json
import uvicorn
from fastapi import FastAPI, Request

app = FastAPI()

@app.post("/test")
async def main(request: Request):

    json_recvMsg = await request.json()
    print('[x] message received')
    # print(json_recvMsg['test_type'])

    try:
        if json_recvMsg['test_type'] == 'SIMPLE_TEST':  # SIMPLE_TEST
            
            return_msg = {
                'msg_type' : 'SIMPLE_TEST',
                'result' : 'OK'
            }
            return return_msg

        else:
            # not vaild test type into requese messages
            return_msg = {
                'msg_type' : 'NONE',
                'result' : 'ERROR'
            }
            return return_msg
        
    except:
        print("%s Failed" % (json_recvMsg['test_type']))

if __name__ == '__main__':
    uvicorn.run("webServer:app", host='0.0.0.0', port=9100, debug=True)
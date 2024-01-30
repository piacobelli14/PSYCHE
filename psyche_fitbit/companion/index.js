const httpURL = 'https://psyche-api.vercel.app/stored-data'; 
import * as messaging from 'messaging'; 

messaging.peerSocket.addEventListener('message', (event) => {
  if (event.data && event.data.data) {
    const dataString = event.data.data; 
    console.log('Received data from device: ', dataString); 

    sendToServer(dataString);
  }
});

function sendToServer(dataString) {
  const headers = {
    'Content-Type': 'text/plain',
  }; 

  const fetchInit = {method: 'POST', headers, body: dataString}; 

  fetch(httpURL, fetchInit)
    .then((response) => {
      console.log('Server response: ', response.status); 
    })
    .catch((err) => {
      console.error('Error sending data to server:', err);
    });
}
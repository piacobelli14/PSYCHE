import clock from "clock"; 
import document from "document"; 
import * as messaging from "messaging"; 
import { inbox, outbox}  from "file-transfer"; 
import { Accelerometer } from "accelerometer";
import { Gyroscope } from "gyroscope"; 
import { HeartRateSensor } from "heart-rate"; 
import { BodyPresenceSensor } from 'body-presence';
import { battery } from "power"; 

const accel = new Accelerometer(); 
const gyro = new Gyroscope(); 
const hrm = new HeartRateSensor(); 
const bp = new BodyPresenceSensor(); 

const devID = '02'; 

clock.granularity = "minutes";
const timeLabel = document.getElementById("timeLabel");
const dateLabel = document.getElementById("dateLabel");

clock.ontick = (evt) => {
    let today = evt.date;
    let hours = today.getHours();
    const isPM = hours >= 12;
    if (hours > 12) {
        hours = hours - 12;
    } else if (hours === 0) {
        hours = 12;
    }
    let mins = zeroPad(today.getMinutes());
    let period = isPM ? 'PM' : 'AM';

    let day = zeroPad(today.getDate());
    let monthIndex = today.getMonth();
    let dayIndex = today.getDay();

    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    timeLabel.text = `${hours}:${mins} ${period}`;
    dateLabel.text = `${days[dayIndex]}, ${months[monthIndex]} ${day}`;
};

function zeroPad(i) {
    if (i < 10) {
        return "0" + i;
    }
    return i;
} 

function refreshData() {
    if (accel && gyro && hrm) {
        let accX = accel.x ? accel.x.toFixed(2) : '0'; 
        let accY = accel.y ? accel.y.toFixed(2) : '0'; 
        let accZ = accel.z ? accel.z.toFfixed(2) : '0'; 
        let gyroX = gyro.x ? gyro.x.toFixed(2) : '0'; 
        let gyroY = gyro.y ? gyro.y.toFixed(2) : '0'; 
        let gyroZ = gyro.z ? gyro.z.toFixed(2) : '0'; 
        
        let hr = hrm.heartRate ? hrm.heartRate.toString() : '0'; 
        let bpPresent = bpPresent = bp.present ? '1' : '0';
        let batteryLevel = battery.chargeLevel.toString();

        const dataString = `${parseInt(devID)},${accX},${accY},${accZ},${gyroX},${gyroY},${gyroZ},${hr},${bpPresent},${batteryLevel}`;
        console.log(dataString); 

        if (messaging.peerSocket.readyState === messaging.peerSocket.OPEN) {
            messaging.peerSocket.send({ data: dataString });
        }
    }
}

accel.start();
gyro.start();
hrm.start();
bp.start();


setInterval(refreshData, 1000);
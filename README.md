## Generate the public key


1. Create keypair on aws web - "testing"
2. Download the keypair and generate the keygen on same folder.
  - ssh-keygen -y -f testing.pem

## After spin up , need to update as below

1. IGW Route table associate Edge (Internet Gateway)
2. Endpoint -copy the FW subnet interface ID
3. Add EC2 IP/24 to FW interface on IGW Route Table
4. Change Default route to FW ID from IGW on EC2 public route table

![header image](cloudideastar_nfw.jpg)

![header image](AWS_NFW.png)

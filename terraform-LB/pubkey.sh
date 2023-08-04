 #!/bin/bash
 aws s3 cp s3://jenkins-pub-key/jenkins-key.pub /home/ec2-user/key.pub
 chmod 644 /home/ec2-user/key.pub
 cat /home/ec2-user/key.pub >> /home/ec2-user/.ssh/authorized_keys
 chmod 600 /home/ec2-user/.ssh/authorized_keys

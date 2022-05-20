provider "aws" {
access_key = "AKIATHAGUO2PSPMINDHN"
secret_key = "hhg5v2jT7vfIzVrrkt4B5XZ1u9GZGTLoQTjFrk41"
region = "us-east-2"
}

# private windows insatnce

resource "aws_instance" "win-example" {
  ami           = "ami-0323a02a58ca8ce7f"
  instance_type = "t2.micro"
  key_name      = "aazadee"
  associate_public_ip_address = false
  user_data = data.template_file.userdata_win.rendered
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = "${aws_subnet.privatesubnets.id}"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed.id
        ]
  tags = {
    Name = "Firefly-ELM-Dev-Market"
  }

}
output "ip" {

value="${aws_instance.win-example.public_ip}"

}



###user-data#####

data "template_file" "userdata_win" {
  template = <<EOF
<powershell>
Initialize-Disk -Number 1
New-Partition –DiskNumber 1 -DriveLetter E –UseMaximumSize
Set-Partition -DriveLetter E -IsActive $true
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "DATA1"
Initialize-Disk -Number 2
New-Partition –DiskNumber 2 -DriveLetter F –UseMaximumSize
Set-Partition -DriveLetter F -IsActive $true
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel "DATA2"
Initialize-Disk -Number 3
New-Partition –DiskNumber 3 -DriveLetter G –UseMaximumSize
Set-Partition -DriveLetter G -IsActive $true
Format-Volume -DriveLetter G -FileSystem NTFS -NewFileSystemLabel "DATA3"
#chocolaty installation
Get-ExecutionPolicy
Set-ExecutionPolicy AllSigned -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(‘https://chocolatey.org/install.ps1’))
#chrom
Choco install GoogleChrome -y
#winscp
choco install winscp -y
#Matlab
choco install mcr-r2015b -y
#awscli
choco install awscli
</powershell>
<persist>true</persist>
EOF
}

###volume#####

resource "aws_ebs_volume" "vol-1" {
  availability_zone = "us-east-2b"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-1" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol-1.id
  instance_id = aws_instance.win-example.id
}

resource "aws_ebs_volume" "vol-2" {
  availability_zone = "us-east-2b"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-2" {
  device_name = "/dev/xvda"
  volume_id   = aws_ebs_volume.vol-2.id
  instance_id = aws_instance.win-example.id
}

resource "aws_ebs_volume" "vol-3" {
  availability_zone = "us-east-2b"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-3" {
  device_name = "/dev/xvdb"
  volume_id   = aws_ebs_volume.vol-3.id
  instance_id = aws_instance.win-example.id
}

######end-server-1#######



resource "aws_instance" "win-example-2" {
  ami           = "ami-0323a02a58ca8ce7f"
  instance_type = "t2.micro"
  key_name      = "aazadee"
  associate_public_ip_address = false
  user_data = data.template_file.userdata_win-2.rendered
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = "${aws_subnet.privatesubnets-2.id}"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed-2.id
        ]
  tags = {
    Name = "Firefly-ELM-Dev-Forecast"
  }

}

output "ip4" {

value="${aws_instance.win-example-2.public_ip}"

}

#####user-data-2#####

data "template_file" "userdata_win-2" {
  template = <<EOF
<powershell>
Initialize-Disk -Number 1
New-Partition –DiskNumber 1 -DriveLetter E –UseMaximumSize
Set-Partition -DriveLetter E -IsActive $true
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "DATA1"
Initialize-Disk -Number 2
New-Partition –DiskNumber 2 -DriveLetter F –UseMaximumSize
Set-Partition -DriveLetter F -IsActive $true
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel "DATA2"
Initialize-Disk -Number 3
New-Partition –DiskNumber 3 -DriveLetter G –UseMaximumSize
Set-Partition -DriveLetter G -IsActive $true
Format-Volume -DriveLetter G -FileSystem NTFS -NewFileSystemLabel "DATA3"
#chocolaty installation
Get-ExecutionPolicy
Set-ExecutionPolicy AllSigned -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(‘https://chocolatey.org/install.ps1’))
#chrom
Choco install GoogleChrome -y
#winscp
choco install winscp -y
#Matlab
choco install mcr-r2015b -y
#awscli
choco install awscli
</powershell>
<persist>true</persist>
EOF
}

#####volume-2######

resource "aws_ebs_volume" "vol-4" {
  availability_zone = "us-east-2a"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-4" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol-4.id
  instance_id = aws_instance.win-example-2.id
}

resource "aws_ebs_volume" "vol-5" {
  availability_zone = "us-east-2a"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-5" {
  device_name = "/dev/xvda"
  volume_id   = aws_ebs_volume.vol-5.id
  instance_id = aws_instance.win-example-2.id
}

resource "aws_ebs_volume" "vol-6" {
  availability_zone = "us-east-2a"
  size              = 30
}

resource "aws_volume_attachment" "ebs_att-6" {
  device_name = "/dev/xvdb"
  volume_id   = aws_ebs_volume.vol-6.id
  instance_id = aws_instance.win-example-2.id
}

########end-server-2#######


resource "aws_instance" "win-example-3" {
  ami           = "ami-0e67ffd526fedaae4"
  instance_type = "m4.large"
  key_name      = "aazadee"
  associate_public_ip_address = false
  user_data = data.template_file.userdata_win-3.rendered
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = "${aws_subnet.privatesubnets-2.id}"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed-3.id
        ]
  tags = {
    Name = "Firefly-ELM-Dev-Forecast-sql"
  }

}

output "ip5" {

value="${aws_instance.win-example-3.public_ip}"

}

####user-data-3########

data "template_file" "userdata_win-3" {
  template = <<EOF
<powershell>
Initialize-Disk -Number 1
New-Partition –DiskNumber 1 -DriveLetter F –UseMaximumSize
Set-Partition -DriveLetter F -IsActive $true
Format-Volume -DriveLetter F -FileSystem NTFS -NewFileSystemLabel "SQL DATA"
#chocolaty installation
Get-ExecutionPolicy
Set-ExecutionPolicy AllSigned -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(‘https://chocolatey.org/install.ps1’))
#chrom
Choco install GoogleChrome -y
#winscp
choco install winscp -y
#Matlab
choco install mcr-r2015b -y
#awscli
choco install awscli
</powershell>
<persist>true</persist>
EOF
}

#####volume-3######

resource "aws_ebs_volume" "vol-7" {
  availability_zone = "us-east-2a"
  size              = 500
}

#volume-attachment

resource "aws_volume_attachment" "ebs_att-7" {
  device_name = "/dev/xvdd"
  volume_id   = aws_ebs_volume.vol-7.id
  instance_id = aws_instance.win-example-3.id
}

########end-server-3######


#windows Jump servers

resource "aws_instance" "win-example-4" {
  ami           = "ami-0323a02a58ca8ce7f"
  instance_type = "t2.micro"
  key_name      = "aazadee"
  associate_public_ip_address = true
 # user_data = data.template_file.userdata_win.rendered
  subnet_id = "${aws_subnet.publicsubnets.id}"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed-4.id
        ]
  tags = {
    Name = "Firefly_jump_Server"
  }

}

output "ip2" {

value="${aws_instance.win-example-4.public_ip}"

}

resource "aws_instance" "win-example-5" {
  ami           = "ami-0323a02a58ca8ce7f"
  instance_type = "t2.micro"
  key_name      = "aazadee"
  associate_public_ip_address = true
  user_data = data.template_file.userdata_win-4.rendered
  subnet_id = "${aws_subnet.publicsubnets-2.id}"
  vpc_security_group_ids = [
        aws_security_group.kk-ssh-allowed-5.id
        ]
  tags = {
    Name = "Firefly_SFTP_server"
  }

}

output "ip3" {

value="${aws_instance.win-example-5.public_ip}"

}


####user-data######

data "template_file" "userdata_win-4" {
  template = <<EOF
<powershell>
Initialize-Disk -Number 1
New-Partition –DiskNumber 1 -DriveLetter E –UseMaximumSize
Set-Partition -DriveLetter E -IsActive $true
Format-Volume -DriveLetter E -FileSystem NTFS -NewFileSystemLabel "DATA-sftp"
#chocolaty installation
Get-ExecutionPolicy
Set-ExecutionPolicy AllSigned -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString(‘https://chocolatey.org/install.ps1’))
#chrom
Choco install GoogleChrome -y
#winscp
choco install winscp -y
#Matlab
choco install mcr-r2015b -y
#awscli
choco install awscli
#sftp
choco install openssh -y
</powershell>
<persist>true</persist>
EOF
}

#####volume-3######

resource "aws_ebs_volume" "vol-8" {
  availability_zone = "us-east-2b"
  size              = 500
}

#volume-attachment

resource "aws_volume_attachment" "ebs_att-8" {
  device_name = "/dev/xvdd"
  volume_id   = aws_ebs_volume.vol-8.id
  instance_id = aws_instance.win-example-5.id
}



#!/bin/bash

# Redirect all output to /var/log/userdata.log
exec > /var/log/userdata.log 2>&1

# Update the instance
sudo yum update -y

# Install Apache HTTP Server
sudo yum install -y httpd

# Start Apache HTTP Server
sudo systemctl start httpd
sudo systemctl enable httpd

# Install PHP
sudo yum install -y php

# Navigate to the web root directory
cd /var/www/html

# Create a single folder named 'itgenius_folder'
mkdir -p itgenius_folder


# Create the 5 files
echo "IAM: Secure your AWS resources. With AWS IAM, you can control access to AWS services and resources securely." > itgenius_folder/iam.txt

echo "VPC: Design your network your way. Amazon VPC lets you define your own virtual network, including subnets, route tables, and security groups." > itgenius_folder/vpc.txt

echo "EC2: Unleash the power of scalable compute. Amazon EC2 provides secure, resizable compute capacity in the cloud to run your applications." > itgenius_folder/ec2.txt

echo "ECS: Empower your applications with seamless container management. With Amazon ECS, you can easily deploy, manage, and scale Docker containers in the cloud." > itgenius_folder/ecs.txt

echo "R53: Route your traffic effortlessly. Amazon Route 53 connects user requests to infrastructure running in AWS and beyond." > itgenius_folder/r53.txt

echo "ECR: Efficiently manage and deploy container images. Amazon ECR is a fully managed container registry that stores, manages, and deploys Docker container images securely." > itgenius_folder/ecr.txt

echo "S3: Secure and scalable object storage. Amazon S3 provides reliable data storage with data protection, availability, and access management capabilities." > itgenius_folder/s3.txt

echo "EFS: Scalable file storage for EC2. Amazon EFS offers simple, scalable, elastic file storage for Linux-based workloads." > itgenius_folder/efs.txt

echo "EBS: Persistent block storage for EC2. Amazon EBS provides high-performance block storage that is easy to scale and manage." > itgenius_folder/ebs.txt

echo "Lambda: Run code without provisioning servers. AWS Lambda executes your code in response to events, enabling serverless computing." > itgenius_folder/lambda.txt

echo "Secrets Manager: Securely store sensitive information. AWS Secrets Manager helps you protect access to your applications, services, and IT resources without hardcoding credentials." > itgenius_folder/secretsmanager.txt

echo "Certificate Manager: Manage SSL/TLS certificates. AWS Certificate Manager makes it easy to provision, manage, and deploy SSL/TLS certificates for use with AWS services." > itgenius_folder/certificatemanager.txt

echo "RDS: Managed relational database service. Amazon RDS simplifies database setup, management, and scaling with automated backups and monitoring." > itgenius_folder/rds.txt

echo "DynamoDB: Fully managed NoSQL database. Amazon DynamoDB provides fast and flexible data storage for applications requiring low-latency access." > itgenius_folder/dynamodb.txt

echo "CloudTrail: Track AWS API activity. AWS CloudTrail enables governance, compliance, and operational and risk auditing of your AWS account." > itgenius_folder/cloudtrail.txt

echo "CloudWatch: Monitor AWS resources. Amazon CloudWatch provides data and actionable insights to monitor applications, respond to system-wide changes, and optimize resource use." > itgenius_folder/cloudwatch.txt

echo "KMS: Securely manage encryption keys. AWS KMS helps you create, control, and manage encryption keys for securing data across AWS services." > itgenius_folder/kms.txt

# Create index.html with enhanced design and file view functionality
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ITGenius - Dynamic File Viewer</title>
    <style>
        body {
            background: linear-gradient(135deg, #f0e68c, #ffe4e1);
            font-family: 'Arial', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            background-color: #ffffff;
            border-radius: 32px;
            box-shadow: 0px 15px 40px rgba(0, 0, 0, 0.1);
            padding: 50px;
            overflow-y: auto;
        }
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        .header h1 {
            font-size: 48px;
            font-weight: bold;
            color: #00796b;
        }
        .header p {
            font-size: 24px;
            color: #8b0000;
        }
        .file-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }
        .file-card {
            background: linear-gradient(145deg, #48d1cc, #b0e0e6);
            border-radius: 24px;
            padding: 30px;
            text-align: center;
            font-weight: bold;
            font-size: 24px;
            color: #00796b;
            cursor: pointer;
            transition: transform 0.4s, background-color 0.4s;
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.15);
        }
        .file-card:hover {
            background: linear-gradient(145deg, #b0e0e6, #48d1cc);
            transform: scale(1.08);
            color: #ffffff;
        }
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            display: none;
        }
        .modal-content {
            background-color: #ffffff;
            border-radius: 16px;
            padding: 30px;
            width: 60%;
            max-width: 800px;
            text-align: center;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.2);
        }
        .modal-content h2 {
            font-size: 32px;
            margin-bottom: 20px;
            color: #00796b;
        }
        .modal-content p {
            font-size: 18px;
            color: #333333;
        }
        .close-btn {
            background-color: #00796b;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            margin-top: 20px;
            border-radius: 8px;
        }
        .close-btn:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>ITGenius - File Viewer in /var/www/html 🚀</h1>
        <p>Click on a file to view its content.</p>
    </div>
    <div id="file-container" class="file-grid"></div>
</div>

<div class="modal" id="modal">
    <div class="modal-content">
        <h2 id="modal-title">File Content</h2>
        <p id="modal-content"></p>
        <button class="close-btn" onclick="closeModal()">Close</button>
    </div>
</div>

<script>
    async function fetchFiles() {
        try {
            const response = await fetch('/list_files.php');
            const files = await response.json();
            renderFiles(files);
        } catch (error) {
            console.error('Error fetching files:', error);
        }
    }

    function renderFiles(files) {
        const container = document.getElementById('file-container');
        container.innerHTML = '';

        files.forEach(file => {
            const fileCard = document.createElement('div');
            fileCard.className = 'file-card';
            fileCard.textContent = file.name;
            fileCard.onclick = () => viewFile(file.name);
            container.appendChild(fileCard);
        });
    }

    async function viewFile(filename) {
        try {
            const response = await fetch(`/view_file.php?file=${filename}`);
            const content = await response.text();
            document.getElementById('modal-title').textContent = filename;
            document.getElementById('modal-content').textContent = content;
            document.getElementById('modal').style.display = 'flex';
        } catch (error) {
            console.error('Error fetching file content:', error);
        }
    }

    function closeModal() {
        document.getElementById('modal').style.display = 'none';
    }

    document.addEventListener('DOMContentLoaded', fetchFiles);
</script>

</body>
</html>
EOF

# Create list_files.php for dynamic file listing
cat << 'EOF' > list_files.php
<?php
header('Content-Type: application/json');

$folderPath = '/var/www/html/itgenius_folder';
$files = array_diff(scandir($folderPath), array('.', '..'));

$fileList = [];
foreach ($files as $file) {
    $fileList[] = ['name' => $file];
}

echo json_encode($fileList);
EOF

# Create view_file.php for displaying file content
cat << 'EOF' > view_file.php
<?php
$folderPath = '/var/www/html/itgenius_folder';
$file = basename($_GET['file']);
$filePath = $folderPath . '/' . $file;

if (file_exists($filePath)) {
    echo htmlspecialchars(file_get_contents($filePath));
} else {
    echo "File not found.";
}
EOF

# Set permissions
chmod -R 755 /var/www/html

# Restart Apache to apply changes
sudo systemctl restart httpd

# Completion message
echo "Setup complete. Access the application at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"

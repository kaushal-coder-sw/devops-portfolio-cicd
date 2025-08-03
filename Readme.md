
## Features

- Infrastructure as Code using Terraform
- AWS EC2 instance deployment
- Containerized application
- Automated CI/CD pipeline using GitHub Actions
- Simple web application

## Prerequisites

- AWS Account
- GitHub Account
- Terraform installed locally
- Node.js installed locally

## Infrastructure Components

- AWS EC2 instance
- Security Groups
- Docker container
- Application Load Balancer (optional)

## CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Triggers on push events
2. Provisions infrastructure using Terraform
3. Builds and deploys the application
4. Updates the running instance

## Local Development

```bash
# Clone the repository
git clone {repository_url}

# Navigate to project directory
cd devops-portfolio-cicd

# Install dependencies
npm install

# Start local server
node [server.js](http://_vscodecontentref_/1)
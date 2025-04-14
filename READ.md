# Sinatra Cats Deployment

This project demonstrates the deployment of the [Streetbees/cats](https://github.com/Streetbees/cats) Sinatra application using Docker, AWS EKS, GitHub Actions, and monitoring with Datadog and AWS CloudWatch. The infrastructure is set up for fault-tolerance and zero-downtime deployments using blue-green strategies.

---

Directory Structure

1. .github/workflows/ — GitHub Actions CI/CD workflow
2. infra/terraform/ — Terraform configuration for AWS EKS
3. k8s/ — Kubernetes manifests (Deployments, Services)
4. Dockerfile — Sinatra app container configuration



Infrastructure Setup (Terraform)

1. AWS VPC and Subnets are pre-created (you must replace IDs in main.tf)
2. AWS EKS cluster is provisioned using `terraform-aws-modules/eks/aws
3. EKS managed node groups run the app with auto-scaling enabled



CI/CD Pipeline (GitHub Actions)

1. Triggered on main branch push.
2. Builds and pushes Docker image to Docker Hub.
3. Updates kubeconfig with EKS credentials.
4. Performs blue-green deployment (sinatra-green and sinatra-blue).



Zero-Downtime Deployment (Blue-Green Deployment)

Two deployments: sinatra-green (active) and sinatra-blue (standby or next version).
Deploy new version to sinatra-blue, run health checks, and then update the service selector to point to it.



Monitoring & Observability

Datadog

Set up Datadog Agent on all EKS nodes using Helm:

helm repo add datadog https://helm.datadoghq.com
helm install datadog-agent datadog/datadog   --set datadog.apiKey=YOUR_DATADOG_API_KEY   --set datadog.logs.enabled=true   --set datadog.apm.enabled=true


- Tracks logs, APM traces, resource usage, and health metrics

AWS CloudWatch

Automatically gathers logs from EKS via FluentBit or CloudWatch Container Insights.
Enable via EKS node IAM roles and log agent configuration.



Pros and Cons of Tooling

| Tool | Pros | Cons |
|      |      |      |
| Docker | Simple, portable builds | Requires secure secrets handling |
| EKS (AWS)| Scalable, managed Kubernetes | Setup and cost complexity |
| GitHub Actions | Fully integrated, scalable | Secret management requires care |
| Datadog | Full-stack observability, integrations | Can be costly |
| Terraform | Versioned, repeatable infra | Steep learning curve |


Requirements

1. AWS CLI configured with EKS access
2. Docker and kubectl installed
3. Terraform v1.3+
4. Helm v3+ (for Datadog agent install)
5. GitHub repository secrets:
  - `DOCKERHUB_USERNAME`
  - `DOCKERHUB_PASSWORD`
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`



Conclusion

This setup offers a production-ready, scalable, and observable deployment for the Sinatra-based `cats` app using best DevOps practices.

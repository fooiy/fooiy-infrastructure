# fooiy-infrastructure

네이민 : 싹다 스네이크

환경

* prod : 실제 프로덕현 환경
* dev : 개발 환경

# 컨벤션 : 무조건 환경 먼저 시작
- VPC 외곽
  - key-pari : {환경}_{도메인}_{리소스명}
  - s3 : {환경}_{fooiy}
  - ECR : {환경}_{repo명}
  - route53 : ?
- VPC 내부
  - vpc : {환경}_{리소스명}_{CIDR}
  - subnet : {환경}_{리소스명}_{public/private}_{AZ}
  - eip : {환경}_{엮인 리소스명}_{리소스명}
  - igw : {환경}_{리소스명}
  - nat : {환경}_{엮인 리소스명}_{리소스명}
  - route table : (aws_route_table, aws_route_table_association)한군데서 관리
                  {환경}_{엮인 리소스명}_{리소스명}
  - security_group : {환경}_{도메인}_{엮인 리소스명}_{리소스명}
  - ec2 : {환경}_{도메인}_{리소스명}
  - rds : {환경}_{도메인}_{리소스명}
  - ecs : ?
  - lb : {환경}_{도메인}_{리소스명}

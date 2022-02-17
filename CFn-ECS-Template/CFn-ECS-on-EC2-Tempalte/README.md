## RepositoryTitle：CFn-ECS-on-EC2-Tempalte
ECS(EC2)環境を構築するCloudFormationテンプレート。<br>
最低限のリソースのみを定義しているので、新規にECS(EC2)でサービスを作成する際の、土台として使用する。

## 構成図
※準備中

## 事前要件
使用にあたり、事前に以下のリソースを準備しておく必要がある。
- Route53にパブリックホストゾーンが作成済であること
- ACMで管理している上記ホストゾーンで検証済の証明書が作成済であること

## 事前準備
- ecr.ymlをデプロイし、ECRを作成する。※既にECRがあればそちらを使用
- 上記ECRにDockerfileをpushする。※テスト構築が目的であれば、本プロジェクトのDocker-Demoリポジトリのテスト用Dockerfileを使用する

## 使用方法
- 以下の順番通りにCFnテンプレートをデプロイする。<br>
デプロイには各テンプレートに対応したshを使用する
1. network.yml
2. security_group.yml
3. alb.yml
4. add_dns_record.yml
5. ecs_cluster.yml
6. ecs_service.yml

## 初期パラメータ
各テンプレートは「PJprefix」にて、関連付けしている。<br>
初期値は、以下の通りである。<br>
PJprefix="CFn-ECS-on-EC2"<br>
上記パラメータは、sh内にて引数で指定している。

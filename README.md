## Project：CFn-AnsibleEnv-ECS-on-EC2
Ansibleの検証環境をECS(EC2)上に構築するCloudformationテンプレート

## 構成図
![dev-chibiharu-ansible-ecs-env](https://user-images.githubusercontent.com/60125692/152776305-da093d48-7e1c-4eba-ae93-800d28f2946b.png)

## ディレクトリ説明
- docker：<br>
DockerfileやDockerコンポーネント、及びAnsibleコンポーネントを格納しているディレクトリ。<br>
- script：<br>
Cloudformationテンプレートのスタック作成スクリプトを格納しているディレクトリ。<br>
- template：<br>
Cloudformationテンプレートを格納しているディレクトリ。

## 事前準備<br>
環境構築にあたり、事前に以下の要件を満たしている必要がある。<br>
- ドメインを取得済であり、Route53にてパブリックホストゾーンが作成済であること
- ACMにて管理している上記ドメインで検証されたSSL証明書が作成済であること
- キーペアが作成済であること
- 「ssh-keygen」コマンドにて、公開鍵(id.rsa.pub)とそれに紐づく秘密鍵(id.rsa)が作成済であること

## 構築手順<br>
1. ：network.ymlテンプレートでネットワーク環境を作成する。<br>
2. ：security.ymlテンプレートでセキュリティグループを作成する。<br>
3. ：server.ymlテンプレートで踏み台サーバを作成する。<br>
4. ：loadbalancing.ymlテンプレートでApplicationLoadbalancerを作成する。<br>
5. ：route53.ymlテンプレートでホストゾーンへAレコードを登録する。<br>
6. ：ecr.ymlテンプレートでECRを作成する。(必須ではない)<br>
7. ：ecs_cluster.ymlテンプレートでECS Cluster(ホストインスタンス)を作成する。<br>
8. ：事前に用意した公開鍵(id.rsa.pub)とそれに紐づく秘密鍵(id.rsa)を以下のディレクトリに格納する。<br>
(id.rsa.pub) ⇒ ~./docker/target_ansible/publickey
(id.rsa) ⇒ ~./docker/controle_ansible/privatekey
9. ：以下のDockerfileをECRへpush。<br>
ターゲットサーバ ⇒ ~./docker/target_ansible/Dockerfile
コントロールサーバ ⇒ ~./docker/controle_ansible/Dockerfile 
10. ：ecs_service.ymlテンプレートでECSサービス(コンテナ)を作成する。<br>
11. ：踏み台サーバからコントロールサーバへSSH接続し、「~./.ssh/config」にコンテナ情報を記載する。<br>

## 動作確認<br>
- 動作確認1：WebコンテナへのHTTPSアクセス
  - 外部インターネットからドメインを使用し、ALBを介したHTTPSアクセスが可能であることを確認する。<br>
- 動作確認2：Ansibleでの疎通確認<br>
  - コントロールサーバからターゲットサーバへ以下コマンドを押打し、Ansibleでの疎通確認が取れることを確認する。<br>
```bash
$ pwd
/etc/ansible
$ ansible -i hosts xx.xx.xx.xx(ホストインスタンスのプライベートIP) -m ping
```
- 動作確認3：テスト用playbook.ymlの実行<br>
  - 以下、テスト用playbook.ymlを実行し、コントロールサーバからターゲットサーバへのplaybookが実行できることを確認する。<br>
```bash
# コントロールサーバ
$ pwd
/etc/ansible
$ ansible-playbook -i hosts playbook.yml
$ ssh web01
# ターゲットサーバ(web01)
$ pwd
/etc/ec2-user
$ ls
hoge.txt # 左記ファイルが生成されていることを確認
$ exit
# ターゲットサーバ(web02)
$ pwd
/etc/ec2-user
$ ls
hoge.txt # 左記ファイルが生成されていることを確認
```

***
## 参考
[【CFn】Ansibleの検証環境をECS(EC2)上に構築する①(環境構築編)]
[【CFn】Ansibleの検証環境をECS(EC2)上に構築する②(Ansible実行編)]



  

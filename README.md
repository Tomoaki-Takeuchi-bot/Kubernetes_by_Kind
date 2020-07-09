# Kubernetes by Kind

### Kind のインストール

`brew install kind` で OK！

### Cluster の作り方

kind create cluster で作成できる。
但し、このコマンドだとコントロールプレーンのノードのみとなるので
ワークノードを作成するにはローカルファイルに下記の通り、yml ファイルを作成する。

kind.yml
`kind: Cluster`
`apiVersion: kind.x-k8s.io/v1alpha4`
`nodes:`
`- role: control-plane`
`- role: worker`

その上で下記コマンドを実行する。
`kind create cluster --config kind.yml`

### kubectl での操作

- コンテキストの表示<br>
  `kubectl cluster-info --context kind-kind`

- コンテキスト切替（kind に）<br>
  `kubectl config use-context kind-kind`
  Docker Desktop なら GUI で切り替えも可能

### kind のローカルイメージの取得にについて

kind での Dockerimage の反映は専用コマンドが必要<br>
一部ホームページの内容では反映できない。<br>
`kind load -h` で参照の事

- ローカルからのイメージ取得（Dockerimage)<br>
  `kind load docker-image {{*サンプル例:debug}} from host into nodes`

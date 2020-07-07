# Kubernetes by Kind

### Kind のインストール

`brew install kind` で OK！

### Cluster の作り方

kind create cluster で作成できる。
但し、このコマンドだとコントロールプレーンのノードのみとなるので
ワークノードを作成するにはローカルファイルに下記の通り
yml ファイルを作成する。

`kind: Cluster`
`apiVersion: kind.x-k8s.io/v1alpha4`
`nodes:`
`- role: control-plane`
`- role: worker`

その上で下記コマンドを実行する。
`kind create cluster --config kind.yml`

### kubectl での操作

- コンテキストの表示
  `kubectl cluster-info --context kind-kind`

- コンテスト切替（kind に）
  `kubectl config use-context kind-kind`
  Docker Desktop なら GUI で切り替えも可能

-

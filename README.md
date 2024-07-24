# 椅子寝

## サービス概要
寝不足のデスクワーカーが少しでも良い方法で仮眠をできるように  
机と椅子での寝方をユーザー間で共有するサービスとなります。

## このサービスへの思い・作りたい理由
朝から夕方でデスクワークをしながら、  
帰宅後にRUNTEQで学習していく中で  
夜遅くまで続けた場合、寝不足になることが多かったです。

仕事の休憩時間で、机と椅子を使い  
少し工夫しながら短時間の仮眠を取るだけで  
効果的にリフレッシュできたので、睡眠を多く取った場合と比較しても  
デスクワーカーにとって体力をあまり使わず  
頭を使うことが多いと考えた際にコスパが良いと感じました。 

また、よく寝不足になりがちな人は少なくないと思った為、  
上記から仮眠する方法を共有するサービスがあれば良いと考えました。

## ユーザー層について
睡眠不足のデスクワーカーの方を対象にしています。  
少し寝不足であったとしても、効果的な仮眠を取ることで  
自身のパフォーマンスを改善できるようにターゲットを選定しました。

## サービスの利用イメージ
本サービスでは一回の投稿でユーザーが  
以下の情報を基に投稿するCGMとなります。

- 仮眠を行うまでの準備  
- 仮眠する際の寝方や注意点  
- 仮眠後に取るべきアクション  
- 仮眠時に使用した椅子や睡眠グッズ、アイテムなど  

各詳細については以下の内容で考えております。  

▼仮眠を行うまでの準備  
眠るまでどのような状態に持っていくか  
例えば仮眠の30分前に音楽を聴いたり、  
甘いものを食べて適度にリラックスし、眠りやすい状態にするなど  

▼仮眠する際の寝方や注意点  
基本は座っている状態なので  
仮眠を取る際に首の方向や首の高さや椅子の調整方法     
また、公共の場か個室なのか、寝過ごさない為のアラームが必要かどうか等  

▼仮眠後に取るべきアクション  
デスクワーカーの方を想定しているので、  
仮眠後に再度リセットする方法  
例えばコーヒーやエナドリなどで  
カフェインと吸収することで集中力をアップさせるなど  

▼仮眠時に使用した椅子や睡眠グッズ、アイテム  
どのように寝たか近い状態で  
ユーザーが共有できるように使用したものを記入  

例：昇降デスク、ノイズキャンセリングイヤホン、ゲーミングチェア  

上記の詳細に対してユーザーがコメントでレビューを行う等をできるようにし、  
ユーザー間で仮眠方法を共有することを想定しております。  

これにより、興味を持った寝方を発見し、  
少しでも良い仮眠を体験することで  
ユーザーが自身に合った仮眠方法を獲れることが  
価値になるのではないかと考えております。  

## サービスの差別化ポイント・推しポイント
インターネットやSNS上で調査を行った結果  
椅子で寝心地が良い商品レビューや  
効果的な椅子での寝方を類似サービスになるかと思いました。  

しかしながら、これらが掛け合わされたサービスは  
Web上ではないように見受けられました。  

その為、推しポイントとしては  
「寝方✖️仮眠グッズ✖️仮眠前後の状態」を  
まとめてユーザーが投稿することで  
自身に合った適切な仮眠方法を模索できる点です。

また、レビューの低い睡眠グッズであっても   
特定の寝方をすると使用感が上がるなど  
新しい発見ができることも可能だと考えております。  

## 機能候補
MVPリリース時に作成しておきたいもの

 - 会員登録機能
 - ログイン機能
 - ユーザープロフィール設定機能
 - ユーザー投稿機能
 - ユーザー投稿詳細機能
 - 投稿に対するコメント機能
 - 投稿に対するタグ設定機能（仮眠する際に使用したグッズなどを想定）
 - タグ検索機能（オートコンプリートを使用予定）
 - ブックマーク機能
 - パスワードリセット機能

本リリース時に作成しておきたいもの

 - 投稿に対してのいいね機能
 - いいねランキング機能
 - 管理者機能
 - コメントに対するLINE通知機能
 - 楽天APIを使用したグッズ情報登録機能（追加）

## 機能の実装方針予定
 - Javascript
 - Ruby on Rails
 - Docker
 - Tailwind css
 - PostgreSQL
 - Fly.io
 - LINE Messaging API

## 画面遷移図
Figma：https://www.figma.com/file/aNBLcQ5vScCC4GWuGBa7gz/chair_sleep?type=design&node-id=0-1&mode=design&t=rIJoHCkASqtVKoCE-0

## ER図
[(https://lucid.app/publicSegments/view/2d7be760-f6ca-4248-8f5b-fb5ebca502a1/image.jpeg)](https://i.gyazo.com/77fca8d510054d6d2940e2451c3c3976.png)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
    { tag_name: '豚骨' },
    { tag_name: '味噌' },
    { tag_name: '醤油'},
    { tag_name: '塩'},
    { tag_name: '豚骨醤油'},
    { tag_name: '魚介スープ'},
    { tag_name: '坦々麺'},
    { tag_name: '鶏白湯'},
    { tag_name: '油そば'},
    { tag_name: '横浜家系'},
    { tag_name: '二郎系'},
    { tag_name: 'まぜそば'},
    { tag_name: 'つけ麺'},
    { tag_name: 'その他'},
    ])

Admin.create([
    { email: 'admin@test.com',password: 'admin1'}
    ])

User.create([
    { email: 'test@test.com',password: 'aaaaaa',user_name: 'テストくん',introduction: '初めまして'},
    { email: 'sasaki@test.com',password: 'aaaaaa',user_name: '佐々木',introduction: '佐々木です。らーめん好きです'},
    { email: 'tomoya@test.com',password: 'aaaaaa',user_name: '智也',introduction: '初めまして,二郎系ラーメンが好きです'},
    { email: 'masaki@test.com',password: 'shinju',user_name: '真樹',introduction: '石川のラーメンを食べ歩いてます'},
    { email: 'matsumoto@test.com',password: 'ishikawa',user_name: '松本',introduction: 'あっさり系のラーメンを好みます。'},
    { email: 'saori@test.com',password: 'aaaaaa',user_name: '沙織',introduction: '初めまして、味噌ラーメンが好きです'},
    { email: 'oja@test.com',password: 'aaaaaa',user_name: 'おじいちゃん',introduction: '福井のラーメンをいっぱい食べています'},
    ])

# Post.create([
    # { user_id: '1',area_id: '1',shop_id: '1',menu: '塩ラーメン',body: 'あっさりしていてとても美味しいらーめんでした。',rate: '4.5',tag_ids: '豚骨'},
    # { user_id: '1',area_id: '1',shop_id: '1',menu: 'チャーシューメン',body: 'チャーシューが濃厚で美味しかったです',rate: '5',tag_ids: '豚骨'},
    # { user_id: '2',area_id: '1',shop_id: '2',menu: '濃厚豚骨',body: '濃厚でめっちゃ美味しかったです。',rate: '4.5',tag_ids: '豚骨醤油'},
    # { user_id: '3',area_id: '2',shop_id: '6',menu: '二郎系らーめん',body: '二郎系でとても量が多く、満足感がありました',rate: '4',tag_ids: '二郎系'},
    # { user_id: '2',area_id: '2',shop_id: '7',menu: '魚介つけ麺',body: '魚介系のスタンダードなつけ麺で美味でした。',rate: '3',tag_ids: 'つけ麺'},
    # { user_id: '3',area_id: '2',shop_id: '7',menu: '油そば',body: '油そばが濃厚で美味しいです。また行きたいな',rate: '5',tag_ids: '油そば'},
    # { user_id: '5',area_id: '1',shop_id: '5',menu: 'さっぱり煮干し塩ラーメン',body: 'あっさりしていて煮干しの出汁がたまりませんでした。',rate: '2.5',tag_ids: '魚介スープ'},
    # { user_id: '4',area_id: '1',shop_id: '5',menu: '豚骨バリカタ',body: '豚骨でバリカタが美味しかったです。',rate: '4.5',tag_ids: '豚骨'},
    # { user_id: '6',area_id: '1',shop_id: '1',menu: 'チャーシュー味噌ラーメン',body: '濃厚で味噌好きなのでとても満足です。',rate: '4.5',tag_ids: '味噌'},
    # { user_id: '3',area_id: '3',shop_id: '9',menu: '豚骨ラーメン',body: '豚骨好きにはたまらない美味しさでした。',rate: '1.5',tag_ids: '豚骨'},
    # { user_id: '1',area_id: '3',shop_id: '9',menu: '醤油ラーメン',body: 'スタンダードな醤油ラーメンでめっちゃ美味かったです。',rate: '2',tag_ids: '醤油'},
    # ])

Area.create([
    { prefecture: '石川県'},
    { prefecture: '富山県'},
    { prefecture: '福井県'},
    ])

Shop.create([
    { area_id: '1',shop_name: '麺屋石川', address: '石川県金沢市片町1丁目',bussiness_hour: '10:00~20:00'},
    { area_id: '1',shop_name: '石川らあめん', address: '石川県珠洲市',bussiness_hour: '09:00~15:00'},
    { area_id: '1',shop_name: '能登島麺麺', address: '石川県七尾市能登島',bussiness_hour: '12:00~22:00'},
    { area_id: '1',shop_name: '千里浜麺', address: '石川県羽咋市千里浜',bussiness_hour: '08:00~20:00'},
    { area_id: '1',shop_name: '白山豚骨', address: '石川県白山市',bussiness_hour: '10:00~21:00'},
    { area_id: '2',shop_name: '富山麺', address: '富山県黒部市',bussiness_hour: '11:00~18:00'},
    { area_id: '2',shop_name: '砺波めん', address: '富山県砺波市',bussiness_hour: '10:00~20:00'},
    { area_id: '2',shop_name: '立山連峰めん', address: '富山県立山',bussiness_hour: '07:00~10:00'},
    { area_id: '3',shop_name: '麺屋福井', address: '福井県福井市',bussiness_hour: '15:00~24:00'},
    { area_id: '3',shop_name: '麺屋越前', address: '福井県越前市',bussiness_hour: '24:00~28:00'},
    { area_id: '3',shop_name: 'メガネらーめん', address: '福井県鯖江市',bussiness_hour: '12:00~24:00'},
    ])

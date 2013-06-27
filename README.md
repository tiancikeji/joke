joke
====

joke  api

<h3>myjokes</h3>

<h4>Add笑话</h4>
<code>

curl -XPOST http://localhost:3000/api/myjokes


{ myjoke : 

  {
		name: “204958播放”,
		length: 25, //音频时长秒数
		uid: “789abc”,
    description: "this is a joke"
	}, 
  imageFileData: ..., //jpg
  audioFileData: ..., //mp3
 }
 </code>
 返回
 <code>
  成功: { :success => true, :id => @myjoke.id}
  失败: { :success => false }
 </code>

<h4>笑话列表</h4>
date和page不需要
date的结构YYYYMMDD
<code>
curl -XGET http://localhost:3000/api/myjokes?date=20130624&page=1&uid=1234abc
{
  myjokes: [
    {
      id: 104,
      name: "iOSTest",
      picture_url: null,
      audio_url: "audio-3f144c40c9132f9ad715b7203e80f0fa789a349e-1372306598.mp3",
      approved: 1,
      created_at: "2013-06-27 04:16:38.108688",
      updated_at: "2013-06-27 10:28:48.174073",
      uid: "3f144c40c9132f9ad715b7203e80f0fa789a349e",
      description: "123",
      length: 0,
      num_plays: 8,
      full_audio_url: "/audios/104/audio-3f144c40c9132f9ad715b7203e80f0fa789a349e-1372306598.mp3",
      full_picture_url: null,
      num_likes: 0
      },
      ...
    ]
}
</code>

<h4>笑话播放次</h4>
id: 正在播放的笑话的id
<code>
curl -XPOST "http://localhost:3000/api/myjokes/play?id=104&&uid=712d3a45-9295-459c-b191-af3496e8602d"
</code>
返回:
<code>
 成功: { :success => true, :id => joke_id, :num_plays => num_plays}
 失败: { :success => false, :errors => errors }
</code>



<h3>mylike</h3>


<h4>mylike list </h4>
<code>
curl -XGET -d'[user_id]=1' http://localhost:3000/api/likes

{"likes":[{"approved":1,"audio_url":{"url":"/public/audios/1/zhiqingchun.mp3"},"created_at":"2013-06-18T16:19:38Z","id":1,"name":"11","picture_url":{"url":"/public/pictures/1/logo.png"},"updated_at":"2013-06-18T16:32:38Z","user_id":1}]}
</code>


<h4>喜欢／不喜欢笑话</h4>
<code>
</code>

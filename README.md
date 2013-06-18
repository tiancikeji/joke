joke
====

joke  api

<h3>myjokes</h3>

<h4>Add</h4>
<code>
curl -XPOST http://localhost:3000/api/myjokes
</code>

<h4>list</h4>
<code>
curl -XGET http://localhost:3000/api/myjokes

{"myjokes":[{"approved":1,"audio_url":{"url":"/public/audios/1/zhiqingchun.mp3"},"created_at":"2013-06-18T16:19:38Z","id":1,"name":"11","picture_url":{"url":"/public/pictures/1/logo.png"},"updated_at":"2013-06-18T16:32:38Z","user_id":1}]}
</code>


<h3>mylike</h3>

<h4>Add</h4>
<code>
curl -XPOST -d'like[myjoke_id]=1&like[user_id]=1' http://localhost:3000/api/likes

{"like":{"created_at":"2013-06-18T16:44:54Z","id":1,"myjoke_id":1,"updated_at":"2013-06-18T16:44:54Z","user_id":1}}
</code>

<h4>mylike list </h4>
<code>
curl -XGET -d'[user_id]=1' http://localhost:3000/api/likes

{"likes":[{"approved":1,"audio_url":{"url":"/public/audios/1/zhiqingchun.mp3"},"created_at":"2013-06-18T16:19:38Z","id":1,"name":"11","picture_url":{"url":"/public/pictures/1/logo.png"},"updated_at":"2013-06-18T16:32:38Z","user_id":1}]}
</code>

<h4>unlike </h4>
<code>
curl -XDELETE -d'[user_id]=1' http://localhost:3000/api/likes/1

{"success":true}
</code>

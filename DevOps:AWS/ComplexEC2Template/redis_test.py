import redis

r = redis.StrictRedis(host='localhost', port=12000, db=0)
print("set key1 123")
print(r.set('key1', '123'))
print("get key1")
print(r.get('key1'))

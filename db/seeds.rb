User.create!([
  {email: "vitorio@gmail.com",password: 'password123'}
])
ClientApplication.create!([
  {name: "Android", key: "QaOpr3JjNhUCFjOD9tKZMvA5W0Y", secret: "2ydtfZluc_o8yzYinjA8WDBrI4E"},
  {name: "IOS", key: "r0igfQ3BkTqUq6FhBWC22HnzTGI", secret: "tcXZ6RF4idCKEQOWr7C0AIE2JQg"}
])
City.create!([
  {name: "Denpasar", lat: -8.65, long: 115.216667},
  {name: "Jakarta", lat: -6.121435, long: 106.774124},
  {name: "Kuta", lat: -8.723796, long: 115.175228},
  {name: "Ubud", lat: -8.497726, long: 115.263014}
])

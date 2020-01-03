db.createUser(
{
    user: "sharky",
    pwd: "sharky",
    roles: [
      { role: "readWrite", db: "sharky" }
    ]
});

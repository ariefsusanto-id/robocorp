from RPA.Database import Database
from RPA.Robocorp.Vault import FileSecrets

filesecrets = FileSecrets("secrets.json")
secrets = filesecrets.get_secret("databasesecrets")

db = Database()
db.connect_to_database('pymysql',
                    secrets["DATABASE"],
                    secrets["USERNAME"],
                    secrets["PASSWORD"],
                    '127.0.0.1'
                    )
orders = db.query("SELECT * FROM komunitas")
for order in orders:
    print(order)
from RPA.Database import Database
from RPA.Robocorp.Vault import FileSecrets

filesecrets = FileSecrets("secrets.json")
secrets = filesecrets.get_secret("databasesecrets")

db = Database()
db.connect_to_database('psycopg',
                    secrets["training"],
                    secrets["postgres"],
                    secrets["postgres"],
                    '128.199.201.148'
                    )
orders = db.query("SELECT * FROM agenda")
for order in orders:
    print(order)
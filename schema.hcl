schema "public" {}

table "users" {
  schema = schema.public

  column "id" {
    type = int
  }

  column "name" {
    type = varchar(100)
  }

  column "address" {
    type = varchar(255)
    null = true
  }

  column "location" {
    type = varchar(100)
    null = true
  }

  primary_key {
    columns = [column.id]
  }
}

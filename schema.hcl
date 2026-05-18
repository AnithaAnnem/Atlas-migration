schema "public" {}

table "users" {
  schema = schema.public

  column "id" {
    type = int
  }

  column "name" {
    type = varchar(100)
  }

  column "email" {
    type = varchar(255)
    null = true
  }

  primary_key {
    columns = [column.id]
  }
}

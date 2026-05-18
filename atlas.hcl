env "local" {
  src = "file://schema.hcl"

  url = "postgres://postgres:mysecretpassword@127.0.0.1:5432/testdb?search_path=public&sslmode=disable"

  dev = "postgres://postgres:mysecretpassword@127.0.0.1:5432/devdb?search_path=public&sslmode=disable"

  migration {
    dir = "file://migrations"
  }

  schemas = ["public"]
}

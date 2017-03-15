# Mavenlint

Mavenlink Ruby and Javascript linting rules.

## Javascript

Install this package as a dev dependency.

```json
devDependencies: {
  "mavenlint": ">= 1"
}
```

Then, extend `mavenlint` in your `.eslintrc` file.

```json
{
  "extends": "mavenlint"
}
```

## Ruby

Add this gem to your Gemfile. For a Rails project, it may make sense to add it to the development group.

```rb
gem "mavenlint", ">= 1.0.0"
```

Then, inherit from this gem in your `.rubocop.yml`.

```yml
inherit_gem:
  mavenlint: rubocop.yml
```

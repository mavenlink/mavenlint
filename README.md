# Mavenlint

Mavenlink Ruby and Javascript linting rules.

## Javascript

Install this package as a dev dependency.

```bash
yarn add eslint-config-mavenlink --dev
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
gem "mavenlint", git: "https://github.com/mavenlink/mavenlint"
```

Then, inherit from this gem in your `.rubocop.yml`.

```yml
inherit_gem:
  mavenlint: rubocop.yml
```

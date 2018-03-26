# Mavenlint

Mavenlink Ruby and Javascript linting rules.

[![npm version](https://img.shields.io/npm/v/eslint-config-mavenlint.svg?style=flat-square)](https://www.npmjs.com/package/eslint-config-mavenlint)
[![Build Status](https://travis-ci.org/mavenlink/mavenlint.svg?branch=travis)](https://travis-ci.org/mavenlink/mavenlint)

1. [Usage](#usage)
   - [Javascript](#javascript)
   - [Ruby](#ruby)
2. [Developing](#developing)
   - [ESLint Packages](#eslint-packages)
   - [Ruby Gem](#ruby-gem)

## Usage

How to use the Mavenlint lint rules for Javascript or Ruby projects.

### Javascript

Install the Mavenlint ESLint configuration as a dev dependency.

```bash
yarn add eslint-config-mavenlint --dev
```

Then, extend `mavenlint` in your `.eslintrc` file.

```json
{
  "extends": "mavenlint"
}
```

### Ruby

Add Mavenlint to your Gemfile. For a Rails project, it may make sense to add it to the development group.

```rb
gem "mavenlint", git: "https://github.com/mavenlink/mavenlint"
```

Then, inherit from this gem in your `.rubocop.yml`.

```yml
inherit_gem:
  mavenlint: rubocop.yml
```

## Developing

### ESLint Packages

For our NPM packages, we use [yarn workspaces](https://yarnpkg.com/blog/2017/08/02/introducing-workspaces/) to publish multiple packages.

Install dependencies for all packages by running the following from the root of the project:

```
yarn install
```

Run the tests with:

```
yarn test
```

To publish changed packages, first login:

```
yarn login
```

To publish alpha versions for testing in other applications, run:

```
yarn publish-canary
```

To publish release versions, run:

```
yarn publish-packages
```

You will be prompted to select new versions for each changed package. Commits and tags will be generated for each and their version numbers will be updated.

### Ruby Gem

Install dependencies by running the following from the root of the project:

```
bundle install
```

Run the tests with:

```
rspec
```

To publish a new version, first update the `mavenlint.gemspec` file with the new version. And then build and publish the gem with:

```
gem build mavenlint.gemspec
gem publish mavenlinkt-<VERSION NUMBER>.gem
```

Note that `<VERSION NUMBER>` above has to be replaced with the actual version number that you're releasing.

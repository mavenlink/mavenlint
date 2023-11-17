module.exports = {
  extends: 'airbnb',
  rules: {
    'import/no-extraneous-dependencies': [
      'off',
      { devDependencies: true, optionalDependencies: false, peerDependencies: false },
    ],
    'import/no-unresolved': 'off',
    'max-len': ['error', {
      code: 240,
      ignoreComments: true,
      ignoreStrings: true,
    }],
    'import/no-commonjs': 'error',
    'eol-last': ['error', 'always'],
    'no-unused-expressions': ['error', { allowTernary: true }],
    'arrow-body-style': 'off',
    'arrow-parens': 'off',
    'func-names': 'off',
    'dot-notation': 'off',
    'no-console': 'error',
    'no-multiple-empty-lines': ["error", { "max": 1 }],
    'no-use-before-define': ["error", { "functions": false, "classes": true }],
  },
};

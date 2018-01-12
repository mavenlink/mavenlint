module.exports = {
  extends: 'airbnb',
  plugins: ['mavenlint'],
  rules: {
    'import/no-extraneous-dependencies': [
      'off',
      { devDependencies: true, optionalDependencies: false, peerDependencies: false },
    ],
    'import/no-unresolved': 'off',
    'max-len': ['error', {
      code: 120,
      ignoreComments: true,
      ignoreStrings: true,
    }],
    'import/no-commonjs': 'error',
    'eol-last': ['error', 'always'],
    'no-unused-expressions': ['error', { allowTernary: true }],
    'arrow-body-style': 'off',
    'func-names': 'off',
    'react/jsx-boolean-value': 'off',
    'no-console': 'error',
    'no-multiple-empty-lines': ["error", { "max": 1 }],
    'mavenlint/use-flux-standard-actions': 'error',
  }
};

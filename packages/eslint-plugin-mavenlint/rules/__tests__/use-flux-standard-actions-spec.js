import { RuleTester } from 'eslint';
import rule from '../use-flux-standard-actions';

const ruleTester = new RuleTester();

ruleTester.run('use-flux-standard-actions', rule, {
  valid: [
    {
      code: 'function test() { return { type: "FOO" }; }',
      filename: 'lib/action-creators/foo.js',
    },
  ],
  invalid: [
    {
      code: 'function test() { return { type: "FOO", data: "BAR" } }',
      filename: 'lib/action-creators/foo.js',
      errors: [{ type: 'ReturnStatement' }],
    }
  ],
});

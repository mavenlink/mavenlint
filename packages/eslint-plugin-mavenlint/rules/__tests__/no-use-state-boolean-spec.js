import { RuleTester } from 'eslint';
import rule from '../no-use-state-boolean';

const ruleTester = new RuleTester();

ruleTester.run('no-use-state-boolean', rule, {
  valid: [
    // Inside of our custom useToggle hook
    {
      code: 'useState(true);',
      filename: 'hooks/use-thing.js',
    },
    {
      code: 'useState(false);',
      filename: 'hooks/use-thing.js',
    },
  ],
  invalid: [
    // Inside of a react component with useState(true)
    {
      code: 'useState(true);',
      filename: 'lib/components/foo.js*',
      errors: [{ type: 'CallExpression' }],
    },
    // Inside of a react component with useState(false)
    {
      code: 'useState(false);',
      filename: 'lib/components/foo.js*',
      errors: [{ type: 'CallExpression' }],
    },
  ],
});
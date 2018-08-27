const enzymeMatchers = [
  'toBeChecked',
  'toBeDisabled',
  'toBeEmptyRender',
  'toExist',
  'toContainReact',
  'toHaveClassName',
  'toHaveHTML',
  'toHaveProp',
  'toHaveRef',
  'toHaveState',
  'toHaveStyle',
  'toHaveTagName',
  'toHaveText',
  'toIncludeText',
  'toHaveValue',
  'toMatchElement',
  'toMatchSelector',
];

module.exports = {
  meta: {
    docs: {
      description: 'do not allow setting up jasmine enzyme if it is not being used',
      category: 'Best Practices',
    },
  },
  create(context) {
    const setupNodes = [];
    let usesEnzymeMatchers = false;

    return {
      CallExpression(node) {
        // Find everywhere jasmineEnzyme was setup.
        if (node.callee.name === 'jasmineEnzyme') {
          setupNodes.push(node);
        }

        // Find assertions. These are calls to `expect` followed by accessing a property on the result.
        if (node.callee.name === 'expect' && node.parent.type === 'MemberExpression') {
          // Get the name of the accessed property (for example, toEqual).
          const matcherName = node.parent.property.name;
          // Determine if the property is one of the enzyme-matchers.
          const isEnzymeMatcher = enzymeMatchers.includes(matcherName);
          if (isEnzymeMatcher && !usesEnzymeMatchers) {
            usesEnzymeMatchers = true;
          }
        }
      },

      'Program:exit': function () {
        // Determine if jasmineEnzyme was setup and we _don't_ use one of its matchers.
        if (setupNodes.length > 0 && !usesEnzymeMatchers) {
          setupNodes.forEach(function (node) {
            context.report({
              node,
              message: 'jasmineEnzyme setup, but never used.',
            });
          });
        }
      },
    };
  },
};

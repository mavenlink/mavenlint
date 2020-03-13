module.exports = {
  meta: {
    docs: {
      description: 'prevent using booleans with useState',
      category: 'Best Practices'
    }
  },
  create(context) {
    return {
      CallExpression(node) {
        const path = context.getFilename();
        // return if we are in a custom hook
        if(path.includes('hooks') && path.includes('use-')) { return; }

        // return unless the callee is useState
        if(node.callee.name !== 'useState') { return; }

        const initialState = node.arguments[0];
        if(initialState) {
          if(initialState.type === 'Literal' && (initialState.value === true || initialState.value === false)) {
            context.report({
              node,
              message: 'Boolean literal in useState. Use useToggle instead. See https://github.com/mavenlink/welcome/wiki/Lint-Errors#no-use-state-boolean',
            });
          }
        }
      }
    }
  }
};
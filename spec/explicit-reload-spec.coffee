{WorkspaceView} = require 'atom'
ExplicitReload = require '../lib/explicit-reload'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ExplicitReload", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('explicit-reload')

  describe "when the explicit-reload:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.explicit-reload')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'explicit-reload:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.explicit-reload')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'explicit-reload:toggle'
        expect(atom.workspaceView.find('.explicit-reload')).not.toExist()

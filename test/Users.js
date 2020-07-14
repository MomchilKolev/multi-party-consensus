const Users = artifacts.require('Users')

contract('Users', accs => {
  it('Register member', async () => {
    const instance = await Users.deployed()
    await instance.register(0, { from: accs[0]})
    const user = await instance.users(accs[0])
    assert.equal(+user.id, 0)
    assert.equal(+user.role, 0)
  })
  it('Register admin', async () => {
    const instance = await Users.deployed()
    await instance.register(1, { from: accs[1]})
    const user = await instance.users(accs[1])
    assert.equal(+user.id, 1)
    assert.equal(+user.role, 1)
  })
  it("Deactivate contract", async () => {
    try {
      const instance = await Users.deployed()
      await instance.setOperational(false);
      await instance.register(1, { from: accs[2] })
    } catch (err) {
      assert.equal(err.reason, "Contract is not operational")
    }
  })
})
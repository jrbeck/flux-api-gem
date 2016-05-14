shared_examples 'api_concern' do
  it 'can get the metadata for projects by id' do
    stub_request(:get, 'https://metova.fluxhq.io/api/projects/metadata.json?ids=1,2')
      .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
      .to_return(status: 200, body: '[{"id": 1, "key": "IULG", "metadata": { "random": "NBLhH1DqYVQUz4Gv_Qej" }, "type": "Project", "revision": "unknown" }, { "id": 2, "metadata": { "random": "CeVtiXrk8S34okftvbS8" }, "type": "Project", "revision": "unknown" }]', headers: { 'Content-Type' => 'application/json' })
    expect(subject.metadata([1, 2]).count).to eq 2
  end

  it 'can set the metadata for a project by id' do
    stub = stub_request(:put, 'https://metova.fluxhq.io/api/projects/1.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' }, body: { project: { metadata: { random: 'NBLhH1DqYVQUz4Gv_Qej' } } })
           .to_return(status: 200, body: '[{"id": 1, "key": "IULG", "metadata": { "random": "NBLhH1DqYVQUz4Gv_Qej" }, "type": "Project", "revision": "unknown" }, { "id": 2, "metadata": { "random": "CeVtiXrk8S34okftvbS8" }, "type": "Project", "revision": "unknown" }]', headers: { 'Content-Type' => 'application/json' })
    expect(subject.set_metadata(1, random: 'NBLhH1DqYVQUz4Gv_Qej'))
    expect(stub).to have_been_requested
  end

  it 'can get the accounts' do
    accounts = [{ id: 1, name: 'Account 1' }, { id: 2, name: 'Account 2' }]
    stub = stub_request(:get, 'https://metova.fluxhq.io/api/accounts.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
           .to_return(status: 200, body: accounts.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(subject.accounts).to eq accounts
    expect(stub).to have_been_requested
  end

  it 'can get the products' do
    products = [{ id: 1, name: 'Product 1' }, { id: 2, name: 'Product 2' }]
    stub = stub_request(:get, 'https://metova.fluxhq.io/api/products.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
           .to_return(status: 200, body: products.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(subject.products).to eq products
    expect(stub).to have_been_requested
  end

  it 'can get the projects' do
    projects = [{ id: 1, name: 'Project 1', key: 'PROJ1' }, { id: 2, name: 'Project 2', key: 'PROJ1' }]
    stub = stub_request(:get, 'https://metova.fluxhq.io/api/projects.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
           .to_return(status: 200, body: projects.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(subject.projects).to eq projects
    expect(stub).to have_been_requested
  end

  it 'can get the users' do
    users = [{ id: 1, name: 'User 1' }, { id: 2, name: 'User 2' }]
    stub = stub_request(:get, 'https://metova.fluxhq.io/api/users.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
           .to_return(status: 200, body: users.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(subject.users).to eq users
    expect(stub).to have_been_requested
  end

  it 'can get the account links' do
    account_links = [{ account_id: 1, user_id: 1 }, { account_id: 2, user_id: 2 }]
    stub = stub_request(:get, 'https://metova.fluxhq.io/api/account_links.json')
           .with(headers: { 'Accept' => '*/*,version=3', 'Authorization' => 'Token abc123' })
           .to_return(status: 200, body: account_links.to_json, headers: { 'Content-Type' => 'application/json' })
    expect(subject.account_links).to eq account_links
    expect(stub).to have_been_requested
  end
end

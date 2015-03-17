shared_examples 'api_concern' do
  it 'a user can get the metadata for projects by id' do
    stub_request(:get, "https://metova.fluxhq.io/api/projects/metadata.json?ids=1,2").
        with(:headers => {'Accept'=>'*/*,version=3', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Token abc123', 'User-Agent'=>'Faraday v0.9.1'}).
        to_return(:status => 200, :body => '[{"id": 1, "key": "IULG", "metadata": { "random": "NBLhH1DqYVQUz4Gv_Qej" }, "type": "Project", "revision": "unknown" }, { "id": 2, "metadata": { "random": "CeVtiXrk8S34okftvbS8" }, "type": "Project", "revision": "unknown" }]', :headers => { 'Content-Type' => 'application/json'})
    expect(subject.metadata([1, 2]).count).to eq 2
  end
end
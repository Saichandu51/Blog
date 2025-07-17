def test_index_route(client):
    response = client.get('/')
    assert response.status_code == 200
    assert b'Recent Posts' in response.data

def test_write_route_get(client):
    response = client.get('/write')
    assert response.status_code == 200
    assert b'Create New Post' in response.data

def test_post_creation(client, db):
    test_data = {
        'title': 'Test Post',
        'content': 'This is a test content'
    }
    response = client.post('/write', data=test_data, follow_redirects=True)
    assert response.status_code == 200
    assert b'Your post has been published' in response.data

import pytest
from backend.app import create_app
from backend.app import db as _db

@pytest.fixture
def app():
    app = create_app()
    app.config['TESTING'] = True
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    with app.app_context():
        yield app

@pytest.fixture
def client(app):
    return app.test_client()

@pytest.fixture
def db(app):
    _db.create_all()
    yield _db
    _db.drop_all()

package Portfolio.My.dao;

import Portfolio.My.domain.User;

public interface UserDao {
    int count() throws Exception;

    int deleteAll() throws Exception;

    int delete(String id) throws Exception;

    int insert(User user) throws Exception;

    User select(String id) throws Exception;

    int update(User user) throws Exception;
}

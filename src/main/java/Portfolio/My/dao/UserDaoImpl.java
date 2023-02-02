package Portfolio.My.dao;

import Portfolio.My.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoImpl implements UserDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "Portfolio.My.dao.UserMapper.";

    @Override
    public int count() throws Exception {
        return session.selectOne(namespace + "count");
    }
    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace + "deleteAll");
    }
    @Override
    public int delete(String id) throws Exception {
        return session.delete(namespace + "delete", id);
    }
    @Override
    public int insert(User user) throws Exception {
        return session.insert(namespace + "insert", user);
    }
    @Override
    public User select(String id) throws Exception {
        return session.selectOne(namespace + "select", id);
    }
    @Override
    public int update(User user) throws Exception {
        return session.update(namespace + "update", user);
    }
}
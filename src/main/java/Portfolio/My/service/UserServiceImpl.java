package Portfolio.My.service;

import Portfolio.My.dao.UserDao;
import Portfolio.My.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public int getCount() throws Exception {
        return userDao.count();
    }

    @Override
    public int remove(String id) throws Exception {
        return userDao.delete(id);
    }

    @Override
    public int write(User user) throws Exception {
        return userDao.insert(user);
    }

    @Override
    public User read(String id) throws Exception {
        return userDao.select(id);
    }

    @Override
    public int modify(User user) throws Exception {
        return userDao.update(user);
    }
}

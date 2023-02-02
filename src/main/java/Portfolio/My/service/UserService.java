package Portfolio.My.service;

import Portfolio.My.domain.User;

public interface UserService {
    int getCount() throws Exception;

    int remove(String id) throws Exception;

    int write(User user) throws Exception;

    User read(String id) throws Exception;

    int modify(User user) throws Exception;
}

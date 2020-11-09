package project.yoonju.F.F_P001.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import project.yoonju.F.F_P001.vo.F_P001_D001VO;
import project.yoonju.F.F_P001.vo.F_P001_D001VO2;

@Repository("scoreDAO")
public class F_P001_D001DAOImpl implements F_P001_D001DAO {
	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public List<F_P001_D001VO> selectAllScoreList() throws DataAccessException {
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.selectAllScoreList");
		return scoreList;
	}

	@Override
	public List<F_P001_D001VO> selectScorelist_categoryScore(String score_category) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.selectScorelist_categoryScore", score_category);
		return scoreList;
	}
	

	@Override
	public List<F_P001_D001VO> viewUser_score(String user_id) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.viewUser_score", user_id);
		return scoreList;
	}
	
	
	@Override
	public List<F_P001_D001VO> categoryInfo1(String score_category) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.categoryInfo1", score_category);
		return scoreList;
	}
	
	@Override
	public List<F_P001_D001VO> categoryInfo2(String score_category) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.categoryInfo2", score_category);
		return scoreList;
	}
	
	
	@Override
	public List<F_P001_D001VO> searchUser(String user_id) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.searchUser", user_id);
		return scoreList;
	}
	
	
	@Override
	public List<F_P001_D001VO> selectUserInfo(String user_id) throws DataAccessException{
		List<F_P001_D001VO> scoreList = sqlSession.selectList("yoonju.F.F_P001.F_P001_D001DAO.selectUserInfo", user_id);
		return scoreList;
	}
	
	
}

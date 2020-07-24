module.exports = {

    loginRequired(req, res, next) {

        if (req.user) {
            return next();
        }
        req.flash('error', 'Please Login First');
        return res.redirect('/auth/login');
    }

};
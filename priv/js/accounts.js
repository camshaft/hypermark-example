/**
 * Module dependencies
 */

exports.removeAccount = function(id, env, cb) {
  db.remove(id, env, function(err) {
    if (err) console.error('THERE WAS AN ERROR!', err);
    cb(err);
  });
};

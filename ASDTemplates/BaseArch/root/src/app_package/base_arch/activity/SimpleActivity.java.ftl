package ${packageName}.base_arch.activity;

import ${superClassFqcn};
import android.os.Bundle;
import android.app.ProgressDialog;
import ${packageName}.utils.NotificationDialog;
import android.view.MenuItem;
import android.view.Gravity;
import android.widget.RelativeLayout;
import android.view.ViewGroup;
import android.widget.ProgressBar;

import android.support.annotation.CallSuper;
import android.support.annotation.IdRes;
import android.support.annotation.Nullable;

import butterknife.ButterKnife;
import android.view.inputmethod.InputMethodManager;
import ${packageName}.base_arch.presentation.view.${viewName};
import ${packageName}.base_arch.presentation.presenter.${presenterName};

public abstract class ${activityClass}<T extends ${presenterName}> extends ${superClass} implements ${viewName}{

	protected RelativeLayout progressBarLayout;
    protected ProgressDialog progressDialog;
    protected T presenter;

	protected abstract T createPresenter();

	protected abstract int getLayoutId();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
		presenter = createPresenter();
        findViews();
        presenter.init();
    }

	@Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            // Respond to the action bar's Up/Home button
            case android.R.id.home:
                closeKeyboard();
                return true;
        }
        return super.onOptionsItemSelected(item);
    }

	@CallSuper
	protected void findViews() {
		ButterKnife.bind(getActContext());
    }

    @Override
    public void showProgressDialog() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (progressDialog == null) {
                    progressDialog = new ProgressDialog(${activityClass}.this);
                    progressDialog.setCancelable(false);
                    progressDialog.show();
                }
            }
        });
    }

    @Override
    public void hideProgressDialog() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (progressDialog != null && progressDialog.isShowing()) {
                    progressDialog.dismiss();
                    progressDialog = null;
                }
            }
        });
    }

	@Override
    public void showProgressView() {
        if (progressBarLayout == null)
            setupProgressWheel();
        else
            progressBarLayout.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideProgressView() {
        if (progressBarLayout != null)
            progressBarLayout.setVisibility(View.GONE);
    }

	@Override
    public BaseActivity getActContext() {
        return this;
    }

	@Override
    public void showNotificationDialog(String title, String message) {
        NotificationDialog dialog = new NotificationDialog(getActContext());
        dialog.setTitle(title);
        dialog.setMessage(message);
        dialog.notifyUser();
    }

    protected void closeKeyboard() {
        if (getCurrentFocus() != null) {
            InputMethodManager inputMethodManager = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(getCurrentFocus().getWindowToken(), 0);
        }
    }

	public void replaceFragment(@IdRes int containerId, BaseFragment fragment, @Nullable String tag) {
        getSupportFragmentManager().beginTransaction().replace(containerId, fragment, tag).commit();
    }

    public void replaceFragmentWithBackStack(@IdRes int containerId, BaseFragment fragment, @Nullable String tag) {
        getSupportFragmentManager().beginTransaction().replace(containerId, fragment, tag)
                .addToBackStack(null).commit();
    }

	private void setupProgressWheel() {
        ViewGroup layout = (ViewGroup) findViewById(android.R.id.content).getRootView();
        ProgressBar progressBar = new ProgressBar(this, null, android.R.attr.progressBarStyle);
        progressBar.setIndeterminate(true);
        RelativeLayout.LayoutParams params = new
                RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.MATCH_PARENT);
        progressBarLayout = new RelativeLayout(this);
        progressBarLayout.setGravity(Gravity.CENTER);
        progressBarLayout.addView(progressBar);
        layout.addView(progressBarLayout, params);
    }

}

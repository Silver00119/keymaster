
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../header.jsp" />
<main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
	<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
		<h1 class="h2">Managing ${app.getName()}</h1>
	</div>
	<jsp:include page="../alert.jsp" />
	<form class="form-horizontal" action="manage" method="post">
		<fieldset>
			<div class="card" style="">
				<!-- Text input-->
				<div class="form-group">
					<label class="col-md-4 control-label" for="appname">Application
						Name</label>
					<div class="col-md-4">
						<input id="name" name="name" type="text"
							placeholder="Application Name" class="form-control input-md"
							required="" value="${app.getName()}">

					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">
					<label class="col-md-4 control-label" for="appdescription">Application
						Description</label>
					<div class="col-md-4">
						<textarea id="description" name="description" type="text"
							placeholder="Application Description"
							class="form-control input-md" required="" value="">${app.getDescription()}
        			</textarea>
					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">
					<label class="col-md-4 control-label" for="website">Website</label>
					<div class="col-md-4">
						<input id="website" name="website" type="website" placeholder=""
							value="${app.getWebsite()}" class="form-control input-md">
					</div>
				</div>

				<!-- Number input-->
				<div class="form-group">
					<label class="col-md-4 control-label" for="version">Version</label>
					<div class="col-md-4">
						<input type="number" id="version" name="version"
							class="form-control input-md" value="${app.getVersion()}">
					</div>
				</div>

				<!-- Button -->
				<div class="form-group">
					<div class="col-md-4">
						<button id="update_details" name="update_details"
							class="btn btn-primary" value="true">Update</button>
						<a href="manage/licenses/list" id="manage_license"
							name="manage_license" class="btn btn-primary" value="true">Manage
							Licenses</a> <a href="manage/revoke?id=${app.getID()}"
							id="manage_revoke" name="manage_license" class="btn btn-danger"
							value="true">Revoke</a>
					</div>
				</div>
			</div>
			<hr>
			<div class="card" style="">
				<div class="card-body">
					<h4 class="card-title">
						API Key<br>
					</h4>
					<p class="card-text">
						Regenerating the API key will disable any application with the old
						key.<br>
					</p>
					<div class="row" style="">
						<div class="col-md-9">
							<div class="form-group" style="">
								<input type="text" class="form-control"
									value="${app.getAPIKey()}" disabled>
							</div>
						</div>
						<div class="col-md-1">
							<button id="regenerate_api" name="regenerate_api"
								class="btn btn-primary" value="true">Regenerate</button>
						</div>
					</div>
				</div>
			</div>
			<div class="card" style="">
				<div class="card-body">
					<div class="my-3 p-3 bg-white rounded box-shadow">
						<h6 class="border-bottom border-gray pb-2 mb-0">
							API Documentation<br>
						</h6>

						<div class="media text-muted pt-3">
							<div class="m-5">
								<div class="row" style="">
									<div class="col-sm-4">
										<h3 style="font-weight: 500;">
											Endpoint<br>
										</h3>
									</div>
									<div class="        1 col-sm-12">https://keymaster.monocul.us/api/v1/authenticate/${app.getAPIKey()}</div>
								</div>
								<br>
							</div>
							<span class="badge badge-primary" style="margin-right: 5px;">POST</span>

							<ul class="list-group" style="">
								<strong class="d-block text-gray-dark">
									<li class="list-group-item"><span class="badge" style="">username</span>
										Username&nbsp;</li>
									<li class="list-group-item"><span class="badge">password</span>
										Password</li>
									<li class="list-group-item"><span class="badge" style="">hwid</span>
										Hardware ID</li>
								</strong>
							</ul>
							<br>
							<p></p>
						</div>

						<hr style="">
						<div class="container" style="">
							<div class="m-5">
								<div class="row" style="">
									<div class="col-sm-4  col-3">
										<h3 style="margin-top: 0px;">
											Response <small
												style="width: auto; height: auto; font-family: Courier New;">(application/json)<small><br></small></small>
										</h3>
									</div>
									<div class="  2 1     col-5 1 col-sm-12">
										<p>User with a single license:</p>
										<code>
											[<br>{<br> &nbsp;&nbsp;"activationEpoch":
											1643046225628,<br> &nbsp;&nbsp;"applicationName": "Test
											Application",<br> &nbsp;&nbsp;"licenseName": "Test
											License",<br> &nbsp;&nbsp;"licenseDescription": "Test
											License Description",<br> &nbsp;&nbsp;"type": 1,<br>
											&nbsp;&nbsp;"hardwareID": "123-123-123"<br> }<br>]
										</code>
										<p>
											User with a with multiple licenses:<br>
										</p>
										<code>
											[<br>{<br> &nbsp;&nbsp;"activationEpoch":
											1643046225628,<br> &nbsp;&nbsp;"applicationName": "Test
											Application",<br> &nbsp;&nbsp;"licenseName": "Test
											License",<br> &nbsp;&nbsp;"licenseDescription": "Test
											License Description",<br> &nbsp;&nbsp;"type": 1,<br>
											&nbsp;&nbsp;"hardwareID": "123-123-123"<br>
										</code>
										<div>
											<code> },</code>
										</div>
										<div>
											<code>
												{<br> &nbsp;&nbsp;"activationEpoch": 1643046225629,<br>
												&nbsp;&nbsp;"applicationName": "Test Application",<br>
												&nbsp;&nbsp;"licenseName": "Test License Bonze",<br>
												&nbsp;&nbsp;"licenseDescription": "Test Bronze License
												Description",<br> &nbsp;&nbsp;"type": 2,<br>
												&nbsp;&nbsp;"hardwareID": "123-123-123"<br> }
											</code>
											<code></code>
										</div>
										<div>
											<code></code>
										</div>
										<code>] </code>
										<div class="form-group" style=""></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<small><small> </small></small><small><small>
				</div>
			</div>

		</fieldset>
		<input type="hidden" id="manage" name="manage" value="${app.getID()}">
	</form>
	<hr>
	<form class="form-horizontal" action="manage" method="post">
		<fieldset>
			<div class="card" style="">
				<div class="card-body">
					<h4 class="card-title">
						Assign License<br>
					</h4>
					<p class="card-text">
						Manually assign a license to a specific user on the platform.<br>
					</p>
					<div class="row" style="">
						<div class="col-md-2">
							<div class="form-group" style="">
								<select name="license" class="form-control">
									<c:if test="${licenses == null}">
										<option value="-1" selected>No License Available</option>
									</c:if>
									<c:forEach var="license" items="${licenses}">
										<option value="${license.getID()}" selected>${license.getName()}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="col-md-4">
							<input id="tgtuser" name="tgtuser" type="text"
								placeholder="Username" value="" class="form-control input-md"
								required="">
						</div>
						<div class="col-md-1">
							<button id="add_user" name="add_user" class="btn btn-primary"
								value="true">Assign</button>
						</div>
					</div>
				</div>
			</div>
		</fieldset>
		<input type="hidden" id="manage" name="manage" value="${app.getID()}">
	</form>
</main>
<jsp:include page="../footer.jsp" />
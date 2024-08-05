from flask import Blueprint
from core.apis import decorators
from core.apis.responses import APIResponse
from core.models.teachers import Teacher

from .schema import TeacherSchema
principal_teachers_resources = Blueprint('principal_teachers_resources', __name__)

@principal_teachers_resources.route('/teachers', methods=['GET'], strict_slashes=False)
@decorators.authenticate_principal
def list_teachers(p):
    """Returns list of all teachers"""
    principals_teachers = Teacher.get_teachers_by_principal()
    principals_teachers_dump = TeacherSchema().dump(principals_teachers, many=True)
    return APIResponse.respond(data=principals_teachers_dump)

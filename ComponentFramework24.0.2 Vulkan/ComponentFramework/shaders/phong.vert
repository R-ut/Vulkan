#version 450
#extension GL_ARB_separate_shader_objects : enable
const int NUM_LIGHTS = 3;
layout (location = 0) in  vec4 vVertex;
layout (location = 1) in  vec4 vNormal;
layout (location = 2) in  vec2 texCoords;

layout(binding = 0) uniform CameraUBO {
   
    mat4 projectionMatrix;
	 mat4 viewMatrix;
} camera;

layout(binding = 1) uniform GlobalLightingUBO {
    vec4 position[NUM_LIGHTS];
    vec4 diffuse[NUM_LIGHTS];
	vec4 specular[NUM_LIGHTS];
	vec4 ambient;
} glights;

layout(push_constant) uniform Push {
	mat4 modelMatrix;
	mat4 normalMatrix;
	uint textureIndex;
} push;


layout (location = 0) out vec3 vertNormal;
layout (location = 1) out vec3 lightDir[NUM_LIGHTS];
layout (location = 4) out vec3 eyeDir;
layout (location = 5) out vec2 fragTexCoords;


void main() {
	fragTexCoords = texCoords;
	
	mat3 normalMatrix = mat3(push.normalMatrix);

	vertNormal = normalize(normalMatrix * vNormal.xyz); /// Rotate the normal to the correct orientation 
	//vec3 vertPos = vec3(camera.viewMatrix * push.modelMatrix * vVertex); /// This is the position of the vertex from the origin
	
	vec3 vertPos = vec3(push.modelMatrix * vVertex); // Position in world space
	vec3 vertDir = normalize(vertPos);
	eyeDir = -vertDir;
for (int i = 0; i < NUM_LIGHTS; i++) {
    lightDir[i] = normalize(vec3(glights.position[i]) - vertPos); // Light direction in world space
}
	gl_Position =  camera.projectionMatrix * camera.viewMatrix * push.modelMatrix * vVertex; 
}

